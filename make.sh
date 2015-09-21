if [ -e src/Native/Chartjs.js ]
then
  rm src/Native/Chartjs.js
fi

if [ -e src/Native/wrapper.js ]
then
  rm src/Native/wrapper.js
fi

lsc -kc src/Native/wrapper.ls
cat src/Native/Chart.js > src/Native/Chartjs.js
cat src/Native/wrapper.js >> src/Native/Chartjs.js
rm src/Native/wrapper.js
