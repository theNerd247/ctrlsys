function si = stepinfo(sys)
	si = struct(
		 'RiseTime',NaN
		,'PeakTime',NaN
		,'SettlingTime',NaN
		,'Overshoot',NaN
		,'SteadyStateError',NaN
	);

	try
		% don't waste time doing computations on unstable systems
		if(!isstable(sys))
			error('sys is not a stable system');
		end

		% get the step response
		[y,t,x] = step(sys);

		% the yfinal assuming a step response
		yfinal = dcgain(sys);

		% rise time of the system using the final value theorem
		yab = [0.10,0.90].*yfinal;
		ta = y(0);
		si.RiseTime = tb - ta;

		% 2% settling time of the system
		

		% percent overshoot

	catch
		error_text
	end_try_catch
end


