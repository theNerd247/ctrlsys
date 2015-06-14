% lab1 for control systems
pkg load control

genGraphs = 0;
genStepGraphs = 0;
gen3Graphs = 0;
gen1Graphs = 0;

function strct = newGS(num,denom)
	strct = struct(
		 "func",tf(num,denom)
		,"poles",[]
		,"zeros",[]
	);
	endfunction

function display(strct)
	display(strct.func);
	disp("Poles: ");
	disp(strct.poles);
	disp("Zeros: ");
	disp(strct.zeros);
	endfunction

% transfer functions
GS = {
	 newGS([3,8],[1,6,5])
	,newGS([3,8],[1,0,9])
	,newGS([3,8],[1,2,8])
	,newGS([3,8],[1,-6,8])
};

for i = 1:4
	GS{i}.func = set(GS{i}.func,"outputname",sprintf("G%i",i));
	endfor

% compute poles and zeros and step response of transfer functions
for i = 1:4
	[p,z] = pzmap(GS{i}.func);
	GS{i}.zeros = z;
	GS{i}.poles = p;
	endfor

colo = {
	 "r"
	,"g"
	,"b"
	,"k"
};

% graph the poles, zeros, and step functions
if(genGraphs)
	hold on;
	for i = 1:4
		pzmap(GS{i}.func);
		f = sprintf("../graph/g%i.png",i);
		print -dpng -color f
		close
		endfor
	endif 
	
if(genStepGraphs)
	hold on;
	for i = 1:4
		[y, t] = step(GS{i}.func,5);
		plot(t,y,colo{i});
		axis([0,5,-0.5,2.5]);
		endfor

		title("Step Responses");
		legend("G1","G2","G3","G4");
		print -dpng -color "../graph/step.png";
		close
	endif

% simulate g3
if(gen3Graphs)
	t = 0:(pi/100):(2*pi);
	g3_lsim = lsim(GS{3},sin(2*t+0.8),t);
	
	hold on;
	plot(t,g3_lsim,"b");
	plot(t,sin(2*t+0.8),"g");
	
	title("G3 Simulation");
	legend("lsim(g3)","sin(2t+0.8)");
	xlabel("t");
	
	print -dpng -color '../graph/g3sim.png';
	close
	endif;

% simulate g1
if(gen1Graphs)
	[s t] = gensig("square",10,100);
	g1_lsim = lsim(GS{1},s,t);
	
	hold on;
	plot(t,g1_lsim,"b");
	plot(t,s,"g");
	
	title("G1 Simulation");
	xlabel("t");
	legend("lsim(g1)","input signal");
	
	print -dpng -color '../graph/g1sim.png';
	close
	endif;

% output the data
diary on
GS
diary off
