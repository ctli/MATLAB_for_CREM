clear all
close all
clc
format compact


%% ================================================================== %%
% for value balancing:
[vom0, vom_2007_id] = getgdx('result_2007.gdx', 'vom'); % [g]x[r] = [16]x[34]
[vom, vom_2030_id] = getgdx('result_2030.gdx', 'vom');
d_vom = vom0 - vom; % only Sector g is different
isequal(vom_2007_id, vom_2030_id) % identical; all matrix indecis are idential--> no need to check

[vdm0, vdm_id] = getgdx('result_2007.gdx', 'vdm'); % [g]x[r] = [16]x[34]
[vdm, ~] = getgdx('result_2030.gdx', 'vdm');
isequal(vdm0, vdm) % identical

[vxmd0, vxmd_id] = getgdx('result_2007.gdx', 'vxmd'); % [i]x[rs]x[sr] = [13]x[34]x[34]
[vxmd, ~] = getgdx('result_2030.gdx', 'vxmd');
isequal(vxmd0, vxmd) % identical

[vafm0, vafm_id] = getgdx('result_2007.gdx', 'vafm'); % [i]x[g]x[sr] = [13]x[16]x[34]
[vafm, ~] = getgdx('result_2030.gdx', 'vafm');
d_vafm = vafm0 - vafm; % different

sort_vtwr = zeros(13,34,34); %[i]x[rs]x[sr]
for in = 1:13
    i_target = i{in};
    i_find = strcmp(i_target,vtwr_id{1});
    for rn1 = 1:34
        rs1_target = rs{rn1};
        rs1_find = strcmp(rs1_target,vtwr_id{2});
        for rn2 = 1:34
            rs2_target = rs{rn2};
            rs2_find = strcmp(rs2_target,vtwr_id{3});
            if any(i_find>0) && any(rs1_find>0) && any(rs2_find>0)
                sort_vtwr(in,rn1,rn2) = vtwr(i_find,rs1_find,rs2_find);
            end
        end
    end
end
vtwr = sort_vtwr;

% ==============================
[ddm0, ddm_id] = getgdx('result_2007.gdx', 'ddm'); % [i]x[rs] = [13]x[34]
chk_ddm = ddm0 - vdm0(1:13,:); % almost identical
[ddm, ~] = getgdx('result_2030.gdx', 'ddm');
d_ddm = ddm0 - ddm; % different

[dxmd0, dxmd_id] = getgdx('result_2007.gdx', 'dxmd'); % [i]x[rs]x[sr] = [13]x[34]x[34]
chk_dxmd = vxmd0 - dxmd0; % almost identical
[dxmd, ~] = getgdx('result_2030.gdx', 'dxmd');
d_dxmd = dxmd0 - dxmd; % different

ratio = vtwr./vxmd; % [13x34x34]; use the ratio between vxmd and vtwr (because the substitution is zero) to derive dtwr
% chk1 = (vtwr>1e-6);
% any(isnan(ratio(chk1))) % when ever there is a vtwr value, vxmd is non-zero
ratio(isnan(ratio)) = 0;
dtwr = vxmd.*ratio;
chk_dtwr = dtwr - vtwr; % matched

%% ================================================================== %%
% for energy quantity balancing:
[evd0, evd_id] = getgdx('result_2007.gdx', 'evd'); % [i]x[g]x[rs] = [5]x[15]x[34]
[evd, ~] = getgdx('result_2030.gdx', 'evd_now');
d_evd = evd0 - evd; % different

[eprod0, eprod_id] = getgdx('result_2007.gdx', 'eprod'); % [pe]x[rs] = [3]x[33]; COL/CRU/GAS
[eprod, ~] = getgdx('result_2030.gdx', 'eprod_now');
d_eprod = eprod0 - eprod; % different

[evt0, evt_id] = getgdx('result_2007.gdx', 'evt'); % [i]x[g]x[rs] = [5]x[15]x[24]
% [evt, ~] = getgdx('result_2030.gdx', 'evt');
% isequal(evt0, evt) % identical
[evt, ~] = getgdx('result_2030.gdx', 'evt_now');
d_evt = evt0 - evt; % different


