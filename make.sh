if [ -e src/Native/Chartjs.js ]
then
  rm src/Native/Chartjs.js
fi

if [ -e src/Native/Wrapper.js ]
then
  rm src/Native/Wrapper.js
fi

lsc -kc src/Native/Wrapper.ls
cat src/Native/Chart.js > src/Native/Chartjs.js
cat src/Native/Wrapper.js >> src/Native/Chartjs.js
rm src/Native/Wrapper.js
