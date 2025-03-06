function ray_directions = TLSscanner(alpha_max, beta_ang, alpha_res, beta_res)
    % Generate alpha and beta angles
    alpha_angles = 0:alpha_res:alpha_max;
    
    % Modify beta_angles for 0 to 270 degrees
    beta_angles = -90+beta_ang/2:beta_res:270-beta_ang/2;

    % Create meshgrid for alpha and beta angles
    [Alpha, Beta] = meshgrid(alpha_angles, beta_angles);
    
    % Flatten the meshgrid arrays
    Alpha = Alpha(:);
    Beta = Beta(:);
    
    % Calculate the components of the virtual rays
    X = cosd(Beta) .* cosd(Alpha);
    Y = cosd(Beta) .* sind(Alpha);
    Z = sind(Beta);
    
    % Create the virtual ray direction vectors
    ray_directions = [X, Y, Z];


end