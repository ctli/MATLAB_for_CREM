% function [return_value,return_index, return_struct] = getgdx(gdx_filename, query_name)
function [return_value, return_index, return_struct] = getgdx(gdx_filename, query_name, varargin)

r_struct.name = query_name;

% default settings:
r_struct.form = 'full';
r_struct.compress = true; % skip redundant zeros

% if the user specify specific settings, overwrite the defult:
if ~isempty(varargin)
    for a = 1:nargin-2
        switch lower(varargin{a})
            case 'full'
                r_struct.form = 'full';
            case 'sparse'
                r_struct.form = 'sparse';
            case true
                r_struct.compress = true;
            case false
                r_struct.compress = false;
        end
    end
end

dummy = rgdx(gdx_filename, r_struct);

return_value = dummy.val;

uels_dim = size(dummy.uels, 2);
for i = 1:uels_dim
    return_index{i} = dummy.uels{i};
end

return_struct = dummy;

return

