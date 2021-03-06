function [rollAngle, pitchAngle, yawAngle] = computeEulerAnglesFromInertialBodyAxes(ut, rVect, vVect, bodyInfo, bodyX, bodyY, bodyZ)
    R_total = horzcat(bodyX, bodyY, bodyZ);
    %     [R_vvlh_2_inert, ~, ~, ~] = computeVvlhFrame(rVect,vVect);
%   [yawAngle,pitchAngle,rollAngle]=dcm2angle(R_vvlh_2_inert' * R_total,'xyz');

    [R_ned_2_inert, ~, ~, ~] = computeNedFrame(ut, rVect, bodyInfo);
%     [yawAngle,pitchAngle,rollAngle]=dcm2angle(R_ned_2_inert' * R_total,'zyx');
    angles = rotm2eulARH(R_ned_2_inert' * R_total,'zyx');
    
    rollAngle = real(angles(3));
    pitchAngle = real(angles(2));
    yawAngle = real(angles(1));
end