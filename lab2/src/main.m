pkg load control

% converts the lab part results to a latex tabularx line 
function out = toLatex(part)
	out = [];
	for i = 1:7
		out = [out 
		,'\\\midrule','\n' 
		,'\\ ' 
		,num2str(part.kp(i)),'&' 
		,num2str(part.ki(i)),'&' 
		,num2str(part.kd(i)),'&' 
		,num2str(part.results(i).RiseTime),'&' 
		,num2str(part.results(i).PeakTime),'&' 
		,num2str(part.results(i).SettlingTime),'&' 
		,num2str(part.results(i).Overshoot),'&' 
		,num2str(part.results(i).SteadyStateError),'&' 
		,part.results(i).Stability,'&' 
		,part.results(i).Damping,'\n' 
		];
	end
end

% create a default results struct
function strct = newStruct()
	gtemp = tf([1],[1]);
	t = 0:0.1:10;
	strct = stepinfo(step(gtemp,t),t);
	strct.Stability = 'no';
	strct.SteadyStateError = 1;
	strct.Damping = 'no damping';
end

function sys = pid(ki,kp,kd)
	sys = tf([ki],[1]) + tf([kp],[1,0]) + tf([kd,0],[1]);
end

% different lab part generation data
pt1 = struct(
	'kp',[0.1,1,5,10,20,100,1000]
	,'ki',zeros(1,7)
	,'kd',zeros(1,7)
	,'results',{newStruct()}
);

pt2 = struct(
	'kp',ones(1,7)
	,'ki',[1,2,4,10,100,1000,10000]
	,'kd',zeros(1,7)
	,'results',{newStruct()}
);

pt3 = struct(
	'kp',ones(1,7)
	,'ki',zeros(1,7)
	,'kd',[0.01,0.1,0.3,0.5,1,10,100]
	,'results',{newStruct()}
);

pt4 = struct(
	'kp',ones(1,7)
	,'ki',[0.5,1,5,0.5,0.5,0.5,0]
	,'kd',[0.1,0.1,0.1,0.5,1.5,5,100]
	,'results',{newStruct()}
);

% control function
g = tf([20],[1,4,3]);

% feedback function
h = 1;

% time interval for step response
t=0:0.01:10;

pts = [pt1,pt2,pt3,pt4];

latexResults = [];
pn = 0;
for part = pts
	pn = pn +1;
	for i = 1:7
			% our pid loop
			PID = pid(part.kp(i),part.ki(i),part.kd(i));

			% the resulting system: T(s)
			sys = feedback(PID*g,h);

			% run the step response
			sr = step(sys,t);
			si = stepinfo(sr,t);

			% print the step response
			step(sys,t);
			fn = sprintf('part%i-%i.jpg',pn,i)
			print(fn,'-djpeg');
			close;

			%calculate the steady state error and
			%determine stability of system
			si.Stability = 'no';
			si.SteadyStateError = 1;
			if isstable(sys)
					si.Stability = 'yes';
					si.SteadyStateError = 1/(1+dcgain(sys));
			end

			%determine the damping of the system
			[wn,xi] = damp(sys);
			if(xi(1) > 1)
					si.Damping = 'overdamped';
			elseif(xi(1) == 1)
					si.Damping = 'critically damped';
			elseif(xi(1) < 1 && xi(1) > 0)
					si.Damping = 'under damped';
			elseif(xi(1) == 0)
					si.Damping = 'no damping';
			else
					si.Damping = 'na';
			end

			part.results(i) = si;
	end
	latexResults = [latexResults,toLatex(part),'\n'];
end

% save the latex tables
resultsFile = fopen('lab2results.tex','w+');
fprintf(resultsFile, '%s',latexResults);
fclose(resultsFile);


