from sympy import *
from sympy.integrals import *

t, s = symbols('t s')
u = Piecewise((0, t < 0),(1, True))
f = u*cos(3+3*t)
expr = laplace_transform(f,t,s)
print(latex(expr))
