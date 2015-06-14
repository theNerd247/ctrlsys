% lab1 for control systems
pkg load control

%graphics_toolkit('gnuplot');

% transfer functions
g1 = tf([3,8],[1,6,5]);
g2 = tf([3,8],[1,9]);
g3 = tf([3,8],[1,2,8]);
g4 = tf([3,8],[1,-6,8]);

% compute poles and zeros of transfer functions
[p1,z1] = pzmap(g1);
[p2,z2] = pzmap(g2);
[p3,z3] = pzmap(g3);
[p4,z4] = pzmap(g4);

% get the step responses
s1 = step(g1);
s2 = step(g2);
s3 = step(g3);
s4 = step(g4);

% graph the poles and zeros
pdfopts='-dpdf -color';
pzmap(g1);
print -dpng -color '../graph/g1.png';
pzmap(g2);
print -dpng -color '../graph/g2.png';
pzmap(g3);
print -dpng -color '../graph/g3.png';
pzmap(g4);
print -dpng -color '../graph/g4.png';
close

% output the data
