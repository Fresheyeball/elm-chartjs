if [ -e src/Native/Chart.js ]
then
  rm src/Native/Chart.js
fi

bower install chartjs

# Linux
if [ -e bower_components/Chart.js/Chart.js ]
then
  cp bower_components/Chart.js/Chart.js src/Native
fi

# Mac
if [ -e bower_components/chartjs/Chart.js ]
then
  cp bower_components/chartjs/Chart.js src/Native
fi

rm -r bower_components
