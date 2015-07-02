function scatterColors(x,ys)
  hold on;
  colors = 1:rows(colormap());
  i = 1;
  for y = ys
    scatter(x,y,[],colors(i));
    i+=1;
  end
end
