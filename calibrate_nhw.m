clear all
close all
clc
format compact

gdx_filename = 'result_calibration.gdx';
[NHWCALI, NHWCALI_id] = getgdx(gdx_filename, 'NHWCALI');

nhwgr = (NHWCALI.^(1/20))-1;
nhwgr(NHWCALI==0) = 0;
nhwgr = roundn(nhwgr,-4);

