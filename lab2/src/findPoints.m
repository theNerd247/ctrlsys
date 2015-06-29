% like interp1 except it returns the x values of all the interpolated values of
% y(xi). For example:
%
% findPoints(sin(t),t,0) would return [0,pi,2*pi,...] assuming t >= 0
%
% NOTE: make sure t has a large number of elements otherwise the interpolation
% will not be as accurate
function ys = findPoints(y,x,yi,c)

	ys = [];
	if (length(y) < 2 || length(x) < 2)
		return;
	else
	
	% find our first interpolated x value by taking the best of the two methods
	% for determining the interpolation
	xi1 = interp1(y,x,yi,'linear');
	xi2 = interp1(y,x,yi,'nearest');

	xi = xi1;
	if (abs(interp1(x,y,xi2) - yi) < abs(interp1(x,y,xi1) - yi))
		xi = xi2
	end

	
	if(!isnan(xi))
		% divide the coordinates skipping over our newly found x value
		xil = xir = [];
		yil = yir = [];
	
		for i = 1:length(x)
			if (x(i) < xi)
				xil = [xil,x(i)];
				yil = [yil,y(i)];
			elseif(x(i) > xi)
				xir = [xir,x(i)];
				yir = [yir,y(i)];
			end
		end

		hold on 
		plot(xi,c+yi,'k+');
		plot(xil,c+yil,'r');
		sleep(1);
		plot(xir,c+yir,'g');
		c = c+1;
		sleep(1);
		hold off;
	
		% get the values for the next set
		xsl = findPoints(yil,xil,yi,c);
		xsr = findPoints(yir,xir,yi,c);
	

		ys = [xi,xsl,xsr];
	end

end

