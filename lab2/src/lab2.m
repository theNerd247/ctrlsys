function [] = lab2()

pt1 = struct(...
'kp',[0.1,1,5,10,20,100,1000]...
,'ki',zeros(1,7)...
,'kd',zeros(1,7)...
,'results',{newStruct()}...
);

pt2 = struct(...
'kp',ones(1,7)...
,'ki',[1,2,4,10,100,1000,10000]...
,'kd',zeros(1,7)...
,'results',{newStruct()}...
);

pt3 = struct(...
'kp',ones(1,7)...
,'ki',zeros(1,7)...
,'kd',[0.01,0.1,0.3,0.5,1,10,100]...
,'results',{newStruct()}...
);

pt4 = struct(...
'kp',ones(1,7)...
,'ki',[0.5,1,5,0.5,0.5,0.5,0]...
,'kd',[0.1,0.1,0.1,0.5,1.5,5,100]...
,'results',{newStruct()}...
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
        fn = sprintf('part%i-%i',pn,i)
        legend(sprintf('kp: %.2d, ki: %.2d, kd: %.2d',part.kp(i),part.ki(i),part.kd(i)));
        print([fn,'.jpg'],'-djpeg');
        close;

        %calculate the steady state error and...
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
                si.Damping = 'unstable system';
        end

        part.results(i) = si;
    end
    
    fn = sprintf('part%i',pn);
    sfprintf([fn,'.tex'],toPrintTable(part,'\\\midrule\\','&'));
    sfprintf([fn,'.csv'],toPrintTable(part,'',','));
end

end

% prints text to a file
function sfprintf(fileName,str)
    fl = fopen(fileName,'w+');
    fprintf(fl, '%s',str);
    fclose(fl);
end

% converts the lab part results to a text table where each row is a single
% experiment
function out = toPrintTable(part,preline,delim)
out = [];
for i = 1:7
		out = [out ...
        ,'\n',preline...
		,num2str(part.kp(i)),delim ...
		,num2str(part.ki(i)),delim ...
		,num2str(part.kd(i)),delim ...
		,num2str(part.results(i).RiseTime),delim ...
		,num2str(part.results(i).PeakTime),delim ...
		,num2str(part.results(i).SettlingTime),delim ...
		,num2str(part.results(i).Overshoot),delim ...
		,num2str(part.results(i).SteadyStateError),delim ...
		,part.results(i).Stability,delim ...
		,part.results(i).Damping ...
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
