set terminal png
set output '/www/demo_form/plot.png'
set title 'Regression Line: y = 13 + 0*x'
set xlabel 'X-axis'
set ylabel 'Y-axis'
plot 13 + 0*x with lines title 'y = 13 + 0*x'
