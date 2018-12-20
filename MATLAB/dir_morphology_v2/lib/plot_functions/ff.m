cla
clf

figure(1)

j = 1;

for i = 33:150

    s = char(i);
    strng = sprintf('%d %s', i, char(i));
    text(j, 1, strng, 'Rotation', -90, 'FontSize', 5);

    j = j - 0.01;

end

print(gcf, '-depsc', '-r800', 'b.eps');
