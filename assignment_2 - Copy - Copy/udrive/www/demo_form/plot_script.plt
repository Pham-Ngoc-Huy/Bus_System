set terminal png
set output '/www/demo_form/plot.png'
set title 'Regression Line: y = 30.5517143995441 + 0.112471065252583*x'
set xlabel 'X-axis'
set ylabel 'Y-axis'
plot 30.5517143995441 + 0.112471065252583*x with lines title 'y = 30.5517143995441 + 0.112471065252583*x'
