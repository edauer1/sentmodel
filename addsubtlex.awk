BEGIN{
	while(getline<"SUBTLus.tmp">0){
        	trans[tolower($1)] = $2
		#print $1,trans[$1]
		}
}
{

temp = $3

nsyll = gsub("-","-",temp)

if(trans[tolower($1)]){
print $1","$2","$3","$4","$5","nsyll","trans[tolower($1)]
}else{
print $1","$2","$3","$4","$5","nsyll",NA"

} 
}
