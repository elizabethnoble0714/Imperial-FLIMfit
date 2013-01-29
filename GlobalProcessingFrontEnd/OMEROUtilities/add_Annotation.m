function ret = add_Annotation(session,object,sha1,file_mime_type,full_file_name,description,namespace)
        %
        ret = false;
        %
        if isempty(full_file_name) || isempty(full_file_name) || isempty(sha1)...
                || isempty(file_mime_type) || isempty(session) || isempty(object)
            return;
        end;
        %
%    try                               
        iUpdate = session.getUpdateService(); % service used to write object
        %
        file = java.io.File(full_file_name);
        name = file.getName();
        absolutePath = file.getAbsolutePath();
        path = absolutePath.substring(0, absolutePath.length()-name.length());
        %
        originalFile = omero.model.OriginalFileI;
        originalFile.setName(omero.rtypes.rstring(name));
        originalFile.setPath(omero.rtypes.rstring(path));
        originalFile.setSize(omero.rtypes.rlong(file.length()));
        originalFile.setSha1(omero.rtypes.rstring(sha1));
        originalFile.setMimetype(omero.rtypes.rstring(file_mime_type));
        %        
        originalFile = iUpdate.saveAndReturnObject(originalFile);        
        % Initialize the service to load the raw data
        rawFileStore = session.createRawFileStore();
        rawFileStore.setFileId(originalFile.getId().getValue());
        %
        % open file and read it - code for small file.
        L = file.length();
        fid = fopen(full_file_name,'r');    
            byteArray = fread(fid,L,'uint8');
            %[filename, permission, machineformat, encoding] = fopen(fid)
        fclose(fid);
                                
        rawFileStore.write(byteArray, 0, L);        
        originalFile = rawFileStore.save();                
        % Important to close the service
        rawFileStore.close();
                                                
        % now we have an original File in DB and raw data uploaded.
        % We now need to link the Original file to the image using the File annotation object. That's the way to do it.
        fa = omero.model.FileAnnotationI;
        fa.setFile(originalFile);
        fa.setDescription(omero.rtypes.rstring(description)); % The description set above e.g. PointsModel
        fa.setNs(omero.rtypes.rstring(namespace)) % The name space you have set to identify the file annotation.
        % save the file annotation.
        fa = iUpdate.saveAndReturnObject(fa);
        %      
        whos_object = whos_Object(session,object.getId().getValue());
        switch whos_object
            case 'Project'
                link = omero.model.ProjectAnnotationLinkI;
            case 'Dataset'
                link = omero.model.DatasetAnnotationLinkI;
            case 'Image'
                link = omero.model.ImageAnnotationLinkI;                
            case 'Screen'
                link = omero.model.ScreenAnnotationLinkI;                
            case 'Plate'
                link = omero.model.PlateAnnotationLinkI;                                
        end;
        %
        if strcmp('unknown',whos_Object(session,object.getId().getValue()))
            link = omero.model.ImageAnnotationLinkI;
        end;
        %
        link.setChild(fa);
        link.setParent(object);
        % save the link back to the server.
        iUpdate.saveAndReturnObject(link);
        %
%     catch ME
%         disp(ME);
%         return;
%     end
    %
    ret = true;    
end