cd ./scripts

for i in *.sh; do 
    echo "running $i"
    /bin/sh $i
done
