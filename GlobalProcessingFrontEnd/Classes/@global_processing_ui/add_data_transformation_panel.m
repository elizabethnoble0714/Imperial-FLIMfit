function handles = add_data_transformation_panel(obj,handles,parent)

   % dataset
    dataset_panel = uiextras.TabPanel( 'Parent', parent );
 

    % data transformation
    data_layout = uiextras.VBox( 'Parent', dataset_panel );
    data_transformation_layout = uiextras.Grid( 'Parent', data_layout, 'Spacing', 1, 'Padding', 3  );
    uicontrol( 'Style', 'text', 'String', 'Data Type ',       'HorizontalAlignment', 'right', 'Parent', data_transformation_layout );
    uicontrol( 'Style', 'text', 'String', 'Smoothing ',       'HorizontalAlignment', 'right', 'Parent', data_transformation_layout );
    uicontrol( 'Style', 'text', 'String', 'Integrated Min. ', 'HorizontalAlignment', 'right', 'Parent', data_transformation_layout );
    uicontrol( 'Style', 'text', 'String', 'Time Min. ',    'HorizontalAlignment', 'right', 'Parent', data_transformation_layout );
    
    handles.data_type_popupmenu = uicontrol( 'Style', 'popupmenu', 'String', {'TCSPC', 'Time Gated'}, 'Parent', data_transformation_layout );
    handles.binning_popupmenu = uicontrol( 'Style', 'popupmenu', 'String', {'None', '3x3 (B&H 1)', '5x5 (B&H 2)', '7x7 (B&H 3)' '9x9 (B&H 4)' '11x11 (B&H 5)'}, 'Parent', data_transformation_layout );
    handles.thresh_min_edit   = uicontrol( 'Style', 'edit', 'String', '0', 'Parent', data_transformation_layout );
    handles.t_min_edit        = uicontrol( 'Style', 'edit', 'String', '0', 'Parent', data_transformation_layout );
    
    uicontrol( 'Style', 'text', 'String', 'Rep. Rate ', 'HorizontalAlignment', 'right', 'Parent', data_transformation_layout );
    uicontrol( 'Style', 'text', 'String', 'Downsample ', 'HorizontalAlignment', 'right', 'Parent', data_transformation_layout );
    uicontrol( 'Style', 'text', 'String', 'Gate Max. ',    'HorizontalAlignment', 'right', 'Parent', data_transformation_layout );
    uicontrol( 'Style', 'text', 'String', 'Time Max. ',    'HorizontalAlignment', 'right', 'Parent', data_transformation_layout );
    
    handles.rep_rate_edit          = uicontrol( 'Style', 'edit', 'String', '80', 'Parent', data_transformation_layout );
    handles.downsampling_popupmenu = uicontrol( 'Style', 'popupmenu', 'String', {'None', '2', '4', '8', '16', '32'}, 'Parent', data_transformation_layout );
    handles.gate_max_edit          = uicontrol( 'Style', 'edit', 'String', '1e10', 'Parent', data_transformation_layout );
    handles.t_max_edit             = uicontrol( 'Style', 'edit', 'String', '1e10', 'Parent', data_transformation_layout );
    
    set(data_transformation_layout,'RowSizes',[22 22 22 22]);
    set(data_transformation_layout,'ColumnSizes',[120 120 70 120]);   
    
   
    
    handles.background_container = uicontainer( 'Parent', data_layout ); 
    handles.background_axes = axes( 'Parent', handles.background_container );
    
    set(data_layout,'Sizes',[150 -1]);
    
    % background
    background_layout = uiextras.VBox( 'Parent', dataset_panel );
    background_layout = uiextras.Grid( 'Parent', background_layout, 'Spacing', 1, 'Padding', 3  );
    
    uicontrol( 'Style', 'text', 'String', 'Background ', 'HorizontalAlignment', 'right', 'Parent', background_layout );
    uicontrol( 'Style', 'text', 'String', 'Background Value ', 'HorizontalAlignment', 'right', 'Parent', background_layout );
    uicontrol( 'Style', 'text', 'String', 'TV Background', 'HorizontalAlignment', 'right', 'Parent', background_layout );
    
    handles.background_type_popupmenu = uicontrol( 'Style', 'popupmenu', 'String', {'None', 'Single Value', 'Image'}, 'Parent', background_layout );
    handles.background_value_edit = uicontrol( 'Style', 'edit', 'String', '0', 'Parent', background_layout );
    handles.tvb_define_pushbutton = uicontrol( 'Style', 'pushbutton', 'String', 'Define', 'Parent', background_layout );
    
    
    set(background_layout,'RowSizes',[22 22 22]);
    set(background_layout,'ColumnSizes',[120 250]);
    
    % irf transformation
    irf_layout = uiextras.VBox( 'Parent', dataset_panel );
    irf_transformation_layout = uiextras.Grid( 'Parent', irf_layout, 'Spacing', 1, 'Padding', 3 );

    uicontrol( 'Style', 'text', 'String', 'Time crop ', 'HorizontalAlignment', 'right', 'Parent', irf_transformation_layout );
    uicontrol( 'Style', 'text', 'String', 'Background ', 'HorizontalAlignment', 'right', 'Parent', irf_transformation_layout );
    uiextras.Empty( 'Parent', irf_transformation_layout );
    uicontrol( 'Style', 'text', 'String', 'G factor ', 'HorizontalAlignment', 'right', 'Parent', irf_transformation_layout );
    uicontrol( 'Style', 'text', 'String', 'IRF Shift ', 'HorizontalAlignment', 'right', 'Parent', irf_transformation_layout );
       
    irf_crop_layout = uiextras.HBox( 'Parent', irf_transformation_layout );
    handles.t_irf_min_edit = uicontrol( 'Style', 'edit', 'String', '0', 'Parent', irf_crop_layout );
    uicontrol( 'Style', 'text', 'String', '-', 'Parent', irf_crop_layout );
    handles.t_irf_max_edit = uicontrol( 'Style', 'edit', 'String', '1e10', 'Parent', irf_crop_layout );
    set(irf_crop_layout,'Sizes',[-1 20 -1])
    
    handles.irf_background_edit = uicontrol( 'Style', 'edit', 'String', '0', 'Parent', irf_transformation_layout );
    handles.afterpulsing_correction_checkbox = uicontrol( 'Style', 'checkbox', 'String', 'Background due to afterpulsing', 'Parent', irf_transformation_layout );
    handles.g_factor_edit = uicontrol( 'Style', 'edit', 'String', '1', 'Parent', irf_transformation_layout );
    handles.t0_edit = uicontrol( 'Style', 'edit', 'String', '0', 'Parent', irf_transformation_layout );
    
    uiextras.Empty( 'Parent', irf_transformation_layout );
    handles.irf_background_guess_pushbutton = uicontrol( 'Style', 'pushbutton', 'String', 'Estimate', 'Parent', irf_transformation_layout );
    uiextras.Empty( 'Parent', irf_transformation_layout );
    handles.g_factor_guess_pushbutton = uicontrol( 'Style', 'pushbutton', 'String', 'Estimate', 'Parent', irf_transformation_layout );
    handles.t0_guess_pushbutton = uicontrol( 'Style', 'pushbutton', 'String', 'Estimate', 'Parent', irf_transformation_layout );
   
    set(irf_transformation_layout,'RowSizes',[22 22 22 22 22]);
    set(irf_transformation_layout,'ColumnSizes',[120 250 120]);

    set(dataset_panel, 'TabNames', {'Data'; 'Background'; 'IRF'});
    set(dataset_panel, 'SelectedChild', 1);

    

end