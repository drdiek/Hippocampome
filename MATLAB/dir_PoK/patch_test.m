clf;
n = 10;
xs = rand(n,1);
ys = rand(n,1);
zs = rand(n,1)*3;
figure(1);
plot3(xs,ys,zs,'r.')
xlabel('x');ylabel('y');zlabel('z');
p  = patchline(xs,ys,zs,'linestyle','-','edgecolor','b',...
    'linewidth',1,'edgealpha',0.2);