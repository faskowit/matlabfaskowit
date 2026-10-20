function cmap = pickcolormap(cmap)
%PICKCOLORMAP Interactively assemble an N-by-3 RGB colormap.
%
%   cmap = pickcolormap
%   cmap = pickcolormap(existingMap)
%
%   Choose a color and click Add Color to append it.
%   Click Done when finished.
%
%   Requires MATLAB R2024a or later because it uses uicolorpicker.

    % Optional starting colormap
    if nargin < 1 || isempty(cmap)
        cmap = zeros(0, 3);
        startingColor = [0.5 0.5 0.5];
    else
        validateattributes(cmap, {'numeric'}, ...
            {'2d', 'real', 'finite'}, mfilename, 'cmap');

        if size(cmap, 2) ~= 3
            error('pickcolormap:InvalidSize', ...
                'The starting colormap must be an N-by-3 array.');
        end

        if any(cmap(:) < 0 | cmap(:) > 1)
            error('pickcolormap:InvalidRange', ...
                'All RGB values must be between 0 and 1.');
        end

        cmap = double(cmap);
        startingColor = cmap(end, :);
    end

    % Create the user interface
    fig = uifigure( ...
        'Name',             'Build a Colormap', ...
        'Position',         [500 500 300 400], ...
        'Resize',           'on', ...
        'CloseRequestFcn',  @finishPicking);

    grid = uigridlayout(fig, [4 2]);
    grid.RowHeight = {'fit', 32, 32, 'fit'};
    grid.ColumnWidth = {'1x', '1x'};
    grid.Padding = [15 15 15 15];
    grid.RowSpacing = 10;
    grid.ColumnSpacing = 10;

    instructions = uilabel(grid, ...
        'Text', 'Choose a color, then add it to the colormap.', ...
        'HorizontalAlignment', 'center');

    instructions.Layout.Row = 1;
    instructions.Layout.Column = [1 2];

    picker = uicolorpicker(grid, ...
        'Value', startingColor);

    picker.Layout.Row = 2;
    picker.Layout.Column = 1;

    addButton = uibutton(grid, ...
        'Text', 'Add Color', ...
        'ButtonPushedFcn', @addColor);

    addButton.Layout.Row = 2;
    addButton.Layout.Column = 2;

    undoButton = uibutton(grid, ...
        'Text', 'Undo Last', ...
        'ButtonPushedFcn', @undoLast);

    undoButton.Layout.Row = 3;
    undoButton.Layout.Column = 1;

    doneButton = uibutton(grid, ...
        'Text', 'Done', ...
        'FontWeight', 'bold', ...
        'ButtonPushedFcn', @finishPicking);

    doneButton.Layout.Row = 3;
    doneButton.Layout.Column = 2;

    statusLabel = uilabel(grid, ...
        'HorizontalAlignment', 'center');

    statusLabel.Layout.Row = 4;
    statusLabel.Layout.Column = [1 2];

    updateStatus();

    fprintf(['Choose colors in the desired order.\n' ...
             'Click Done when the colormap is complete.\n\n']);

    % Pause this function while keeping the interface responsive.
    % Deleting the figure causes uiwait to return.
    uiwait(fig);

    fprintf('\nSelected colormap (%d-by-3):\n', size(cmap, 1));
    disp(cmap);


    function addColor(~, ~)
        % Append the currently displayed color
        rgb = reshape(double(picker.Value), 1, 3);
        cmap(end + 1, :) = rgb;

        fprintf('Color %d: [%.6f %.6f %.6f]\n', ...
            size(cmap, 1), rgb(1), rgb(2), rgb(3));

        updateStatus();
    end


    function undoLast(~, ~)
        if isempty(cmap)
            statusLabel.Text = 'There are no colors to remove.';
            return
        end

        removedColor = cmap(end, :);
        cmap(end, :) = [];

        fprintf('Removed: [%.6f %.6f %.6f]\n', ...
            removedColor(1), removedColor(2), removedColor(3));

        % Show the preceding color in the picker
        if ~isempty(cmap)
            picker.Value = cmap(end, :);
        end

        updateStatus();
    end


    function updateStatus()
        numberOfColors = size(cmap, 1);

        if numberOfColors == 0
            statusLabel.Text = 'No colors selected yet.';
        elseif numberOfColors == 1
            statusLabel.Text = '1 color selected.';
        else
            statusLabel.Text = sprintf( ...
                '%d colors selected.', numberOfColors);
        end
    end


    function finishPicking(~, ~)
        % Closing or clicking Done ends uiwait and returns cmap
        if isgraphics(fig)
            delete(fig);
        end
    end
end