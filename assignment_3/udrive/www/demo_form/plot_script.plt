set terminal png
set output '/www/demo_form/plot.png'
set title 'Regression Line: y =  + *x'
set xlabel 'X-axis'
set ylabel 'Y-axis'
plot  + *x with lines title 'y =  + *x'
