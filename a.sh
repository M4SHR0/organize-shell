# setting directory
if [ $# = 0 ]
then
        DIR=$(cd $(dirname $0) && pwd)'/*'
elif [ $# = 1 ]
then
        DIR=$1'/*'
else
        echo Argument Error
fi
#l  files get
for something in $DIR
do
        # split file or dir
        if test -d $something
        then
                dirlist+=($something)
        elif test -f $something
        then
                filelist+=($something)
        fi
done
# mv file
for file in ${filelist[@]}
do
        flag=false
        for dir in ${dirlist[@]}
        do

                if [ ${file##*.} = $dir ]
                then
                        mv $file $dir
                        flag=true
                        break
                fi
        done
        if [ $flag = "false" ]
        then
                if [ ${file##*.} = $file ]
                then
                        mkdir tmp
                        mv $file tmp
                else
                        mkdir ${file##*.}
                        mv $file ${file##*.}
                fi
        fi
done
ls