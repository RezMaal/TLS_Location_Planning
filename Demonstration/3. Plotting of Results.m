%% Plotting
tiledlayout(1,2,"TileSpacing","compact")

nexttile 
for i=1:length(Ns)
    patch(Bounds_BIM{Ns(i),1}(:,1),Bounds_BIM{Ns(i),1}(:,2),Bounds_BIM{Ns(i),1}(:,3),'g','FaceAlpha', 0.25);
end
a=find(x_L==1);
Pc=xyz(a,:); axis equal; hold
Ad=Qc(a,a);
G=graph(Ad);
h=plot(G,'XData',Pc(:,1),'YData',Pc(:,2),'ZData',Pc(:,3));
h.NodeColor = 'r'; % Set nodes to red
h.EdgeColor = 'k'; % Set edges to black
h.MarkerSize = 10;
h.LineWidth = 2;
axis equal; caz =43.5727; cel =29.5760; view(caz,cel)
title('Coverage Guarantee (Linear)')
xx=floor(min(xyz)/5)*5; XX=ceil(max(xyz)/5)*5;
xlim([xx(1),XX(1)]); ylim([xx(2),XX(2)]); zlim([xx(3),XX(3)]); 

nexttile 
for i=1:length(Ns)
    patch(Bounds_BIM{Ns(i),1}(:,1),Bounds_BIM{Ns(i),1}(:,2),Bounds_BIM{Ns(i),1}(:,3),'g','FaceAlpha', 0.25);
end
a=find(result.x==1);
Pq=xyz(a,:); axis equal; hold
Ad=Qc(a,a);
G=graph(Ad);
h=plot(G,'XData',Pq(:,1),'YData',Pq(:,2),'ZData',Pq(:,3));
h.NodeColor = 'b'; % Set nodes to blue
h.EdgeColor = 'k'; % Set edges to black
h.MarkerSize = 10;
h.LineWidth = 2;
axis equal;view(caz,cel)
title('Registrability Guarantee (Quadratic)')
xlim([xx(1),XX(1)]); ylim([xx(2),XX(2)]); zlim([xx(3),XX(3)]);

% Note: The registrability graph only shows the desired surface
% correspondance between km and kM surfaces and does not show
% registrability for stations with more than kM correspondances.