/* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%
   %%%% This program file is part of the book and course
   %%%%   "Parallel Computing for Science and Engineering"
   %%%% by Victor Eijkhout, copyright 2013-7
   %%%%
   %%%% MPI example for vector type
   %%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "mpi.h"

int main(int argc,char **argv) {

  MPI_Comm comm; 
  MPI_Init(&argc,&argv);
  comm = MPI_COMM_WORLD;

  int nprocs,procno;
  MPI_Comm_rank(comm,&procno);
  MPI_Comm_size(comm,&nprocs);

  if (nprocs<2) {
    printf("This program needs at least two processes\n");
    return -1;
  }
  int sender = 0, localsize = 10;
  //localsize - number of elements to be sent to each process

  if (procno==sender) {
    //Create big data array to be sent
    int ndata = localsize*nprocs; //total number of elements in the data array to be sent
    int *data = (int*) malloc(ndata*sizeof(int));
	//data is array of size ndata that contains 0 thru ndata-1
    if (!data) {
      printf("Out of memory\n"); MPI_Abort(comm,0); }

    for (int i=0; i<ndata; i++)
      data[i] = i;

    //Exercise- you need a datatype for sending data. Can you define it here....
    MPI_Datatype scattertype;
    int count,stride,blocklength;
	/**** your code here ****/
	count = localsize, //number of elements to be sent in each block of data
	stride = nprocs, //byte displacement between two conseuctive elements in same dimension
	blocklength = 1;
	MPI_Type_create_hvector(count, blocklength, stride, MPI_INT, &scattertype);
		//hvector : strided vector of elements in memory, where the stride is specified in bytes. 
			//The elements may be non-contiguous in memory, and they may not be equally spaced in memory 
		//vector : non-contiguous in memory, but they must be equally spaced in memory
	MPI_Type_commit(&scattertype);
    //loop over all processes you are sending to
    for (int sendto=0; sendto<nprocs; sendto++) {
      if (sendto==procno)
	continue;
      //or do you define the datatype here? then do a send to the other processor.
	/**** your code here ****/
	int data_offset = ((sendto - 1) * nprocs) + procno;
	MPI_Send(&data[sendto], 1, scattertype, sendto, 0,comm);
	//printf("sendto, nprocs, procn, data_offset = %d, %d, %d, %d\n", sendto, nprocs, procno, data_offset);
	//By providing scattertype as the datatype, you are instudcting MPI to 
	//send a single element of the vector to the destination specified by sendto
	//&data[procno] specifies the starting address of the portion of the vector to be sent
	} 
    //Make sure you free the datatype again- do you do that here or inside the send loop?
	MPI_Type_free(&scattertype);
} else {
    int *mydata = (int*) malloc(localsize*sizeof(int));
    MPI_Recv(mydata,localsize,MPI_INT,sender,0,comm,MPI_STATUS_IGNORE);
    for (int i=0; i<localsize; i++)
      if (mydata[i]%nprocs!=procno)
	printf("[%d] received element=%d, should be %d\n",procno,mydata[i],i*nprocs+procno);
  }
  if (procno==0)
    printf("Finished\n");

  MPI_Finalize();
  return 0;
}
