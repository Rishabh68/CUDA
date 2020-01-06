#include <stdio.h>
#include <cuda_runtime_api.h>
#include <time.h>

/*****************************************************************************
 *
 * 
 * 
 * 
 * 
 * Compile with:
 *   nvcc -o cudapassword 2initialpass_cuda.cu
 * 
 * Dr Kevan Buckley, University of Wolverhampton, 2018 
 ****************************************************************************/

__device__ int is_a_match (char*attempt){
	char plain_password1[] = "RA34";
	char plain_password2[] = "SR56";
	char plain_password3[] = "HV70";
	char plain_password4[] = "TI52";


char *a=attempt;
char *b=attempt;
char *c=attempt;
char *d=attempt;
char *p1=plain_password1;
char *p2=plain_password2;
char *p3=plain_password3;
char *p4=plain_password4;

	while (*a == *p1){
	if (*a == '\0')
	{
	printf("found password: %s\n",plain_password1);
	break;
	}
	a++;
	p1++;
	}

	while (*b == *p2){
	if (*b == '\0')
	{
	printf("found password: %s\n",plain_password2);
	break;
	}
	b++;
	p2++;
	}

	while (*c == *p3){
	if (*c == '\0')
	{
	printf("found password: %s\n",plain_password3);
	break;
	}
	c++;
	p3++;
	}

	while (*d == *p4){
	if (*d == '\0')
	{
	printf("found password: %s\n",plain_password4);
	break;
	}
	d++;
	p4++;
	}
	return 0;
 }



__global__ void kernel (){
char s,a;
char password[5];
password [4] = '\0';

int i = threadIdx.x+65;
int j = threadIdx.y+65;
char firstvalue = i ; 
char secondvalue = j ;
password[0] = firstvalue ;
password [1] = secondvalue;

 for (s='0';s<='9'; s++){
for (a='0';a<='9'; a++){

password[2]= s;
password[3]= a;


is_a_match(password);


 }
 }
 }




int time_difference(struct timespec *start,
 struct timespec *finish, 
  long long int *difference) {
  long long int ds =  finish->tv_sec - start->tv_sec; 
  long long int dn =  finish->tv_nsec - start->tv_nsec; 

  if(dn < 0 ) {
    ds--;
    dn += 1000000000; 
  } 
  *difference = ds * 1000000000 + dn;
  return !(*difference > 0);
}

int main() {
 struct timespec start, finish;
long long int time_elapsed;
clock_gettime(CLOCK_MONOTONIC, &start);
dim3 dim (26,26);
kernel <<<1,dim>>>();
cudaThreadSynchronize();

clock_gettime(CLOCK_MONOTONIC, &finish);
time_difference (&start, &finish, &time_elapsed);
printf("Time elapsed was %lldns or %0.9fs\n", time_elapsed, (time_elapsed/1.0e9));

return 0;
}





























