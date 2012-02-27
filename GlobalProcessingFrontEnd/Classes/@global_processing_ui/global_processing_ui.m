classdef global_processing_ui
   
    properties
        window
        %handles
    end
    
    methods
      
        function obj = global_processing_ui(wait,require_auth)
        
            function vx = split_ver(ver)
                tk = regexp(ver,'([0-9]+).([0-9]+).([0-9]+)','tokens');
                if ~isempty(tk{1})
                    tk = tk{1};
                    vx = str2double(tk{1})*1e6 + str2double(tk{2})*1e3 + str2double(tk{3});
                else 
                    vx = 0;
                end
            end
            
            if nargin < 1
                wait = false;
            end
            if nargin < 2
                require_auth = false;
            end
            
            if ~isdeployed
                addpath_global_analysis()
            else
                wait = true;
            end

            
            try
                v = textread(['GeneratedFiles' filesep 'version.txt'],'%s');
            catch
                v = '[unknown version]';
            end
            
            disp(['Welcome to GlobalProcessing v' v{1}]);
            
            if require_auth
                auth_text = urlread('https://global-analysis.googlecode.com/hg/GlobalAnalysisAuth.txt');
                auth_success = false;
                
                if strfind(auth_text,'external_auth=false')
                    auth_success = true;
                end
                
                min_ver = regexp(auth_text,'min_version=([[0-9]\.]+)','tokens');
                if ~isempty(min_ver)
                    min_ver = split_ver(min_ver{1}{1});
                else
                    min_ver = 0;
                end
                
                if min_ver == 0 || split_ver(v{1}) < min_ver
                    auth_success = false;
                end
                
                if ~auth_success 
                    disp('Sorry, error occured while authenticating.');
                    return
                end
            end
            
                % Open a window and add some menus
            obj.window = figure( ...
                'Name', 'GlobalProcessing', ...
                'NumberTitle', 'off', ...
                'MenuBar', 'none', ...
                'Toolbar', 'none', ...
                'HandleVisibility', 'off', ...
                'Visible','off', ...
                'Units','normalized', ...
                'OuterPosition',[0 0.03 1 0.97]);
                
            obj.setup_layout();
            obj.setup_menu();
            obj.setup_toolbar();

            handles = guidata(obj.window); 

            handles.window = obj.window;
            handles.use_popup = true;
            handles.data_series_controller = flim_data_series_controller(handles);
            handles.fitting_params_controller = flim_fitting_params_controller(handles);
            handles.data_series_list = flim_data_series_list(handles);
            handles.data_intensity_view = flim_data_intensity_view(handles);
            handles.roi_controller = roi_controller(handles);                                                   
            handles.fit_controller = flim_fit_controller(handles);    
            handles.data_decay_view = flim_data_decay_view(handles);
            handles.data_masking_controller = flim_data_masking_controller(handles);
            handles.plot_controller = flim_fit_plot_controller(handles);
            handles.gallery_controller = flim_fit_gallery_controller(handles);
            handles.hist_controller = flim_fit_hist_controller(handles);
            handles.corr_controller = flim_fit_corr_controller(handles);
            handles.graph_controller = flim_fit_graph_controller(handles);
            handles.platemap_controller = flim_fit_platemap_controller(handles);

            handles.menu_controller = front_end_menu_controller(handles);

            set(obj.window,'Visible','on');
            set(obj.window,'CloseRequestFcn',@obj.close_request_fcn);
            
            if wait
                waitfor(obj.window);
            end
            
        end
        
        function close_request_fcn(obj,src,evt)
           
            % Make sure we clean up all the left over classes
            
            handles = guidata(obj.window);
            names = fieldnames(handles);
           
            for i=1:length(names)
                if ishandle(handles.(names{i}))
                    clear handles.(names{i});
                end
            end
            
            
            %clear handles;
            delete(obj.window);
            
            
        end
        
    end
    
end

