import tarfile
import os
import shutil
import subprocess


#   Convert our arguments into a python variable.
args = $ARGS
#   Debug args for our own sanity while running
print(args)

#   The TLE ID should be the (1st) argument
tle_id = int(args[1])
#   The datafile should be the (2nd) argument
input_data=args[2]


#   Next we need to 5pad the TLE-ID.
if (tle_id < 10000):
    tle_id = {'{0:05d}'.format(tle_id)}

print(tle_id)

$SHELL_TLE_ID = tle_id
echo $SHELL_TLE_ID

#   Next we need to grab the lower and higher
#   range number for which folder our tle 
#   file is going to be inside
#   This code could be cleaned up abit.
first_two = int(str(tle_id)[:2])
final = first_two+1
first_two = int('{:<05d}'.format(first_two))
first_two = first_two + 1
final = '{:<05d}'.format(final)

#   print the values we got to sanity check.
print(first_two)
print(final)

#   Download the correct file from the TLE database.
$input_tle_file="https://data.cyverse.org/dav-anon/iplant/home/raptorslab/"+"NORAD_ID/"+str(first_two)+"-"+final+"/"+str(tle_id)+"/"+str(tle_id)+".txt"
wget $input_tle_file

#   Create a python variable with the name of the file.
python_tle_file = str(tle_id)+".txt"


#   This next block unzips the datafile, and then
#   creates some redundant but needed files
#   for the python files to work 
touch tlelist.txt
f = open("tlelist.txt","w+")
f.write(python_tle_file)
f.close()
if os.path.exists("tmp") and os.path.isdir("tmp"):
    shutil.rmtree("tmp")
os.mkdir("tmp")
tar = tarfile.open(input_data, "r:gz")
tar.extractall("tmp")
tar.close()
result = [os.path.join(dp, f) for dp, dn, filenames in os.walk("tmp") for f in filenames if (os.path.splitext(f)[1] == '.fit') and not (f.startswith("._")) ]
f = open("tmplist.txt", "w+")
for r in result:
    f.write(r + "\n")
f.close()


#   We call reduce with these arguments.
python2 reduce.py -p -a Config/@(str(args[3])) -c @(str(args[4])) -x Config/@(str(args[5])) tmplist.txt

#python2 reduce.py -p -a Config/vscope26624_05s1x.ahead -c GAIA-2 -x Config/standard.sex tmplist.txt

#   We use the work from reduce to call findobject.
mkdir work
mv @(str(tle_id) + '_')* work/
touch work/l1
touch work/l2
ls work/*Astr.fit > work/l1
ls work/*Astr.cat > work/l2
paste work/l1 work/l2 > work/tmplist.txt

python2 findObject.py -i work/tmplist.txt -t tlelist.txt

#   this is a bit grotesque, but because the DE wont let
#   us mount the directory AND the pipeline needs to be 
#   run locally. we need to now delete the pipeline before
#   it returns to the DE output directory.

rm -rf Config
rm -rf Images
rm -rf EXAMPLE
rm -rf Utilities
rm -rf tmp
rm -rf work
rm -f *.py
rm -f README.txt
rm -f *.ipynb
rm -f main.xsh
rm -f tlelist.txt
rm -f tmplist.txt
rm -rf de
# rm -rf IMAGES
# rm -rf TLE