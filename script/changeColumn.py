import calendar
import ciso8601
import sys

fileinput = sys.argv[1]
fileoutput = sys.argv[2]

f = open(fileinput, 'rb')
fo = open(fileoutput, 'wb')

# go through each line of the file
for line in f:
    bits = line.split(',')
    # change second column
    bits[0] = str(calendar.timegm(ciso8601.parse_datetime_unaware(bits[0]).timetuple()))
    if "M" in bits[4]:
        bits[4] = str(int(float(bits[4].split()[0])) * 1000000)

    # join it back together and write it out
    fo.write(','.join(bits))

f.close()
fo.close()
