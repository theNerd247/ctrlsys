function [] = prob8

	if(is_octave())
		pkg load control
	end

	%8a
	ga = tf([2],[1,2]);
	pzmap(ga);
	[p,z] = pzmap(ga)
	print -djpg -color 'prob8a.jpg'
	close

	%8b
	gb = tf([20],[1,6,144]);
	pzmap(gb);
	[p,z] = pzmap(gb)
	print -djpg -color 'prob8b.jpg'
	step(gb)
	close

	%8c
	gc = tf([1,5],[1,20,100]);
	pzmap(gc);
	[p,z] = pzmap(gc)
	print -djpg -color 'prob8c.jpg'
	step(gc)

end

function r = is_octave()
	persistent x;
	if (isempty (x))
		x = exist ('OCTAVE_VERSION', 'builtin');
	end
	r = x;
end
