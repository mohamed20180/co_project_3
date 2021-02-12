#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int b[10];
void bubbleSort(int a[], int size_array);
void selectionSort(int a[], int size_array);
void mergeSort(int arr[], int l, int r);
void merge(int a[],int low, int mid, int high);
void swap_bubblesort(int a[], int i);
void swap_selectionsort(int a[],int i,int min);
void print_sort_array (int a[],int size_array);
int Binary_search ( int a[],int size_array, int number);


int main()
{

int size, NAlgo, flag=0 , search_number, index;

printf("Enter a size of array \n");
scanf("%d",&size);
int array[size];

for (int i=0 ; i<size ; i++){
    scanf("%d/n",&array[i] );
}

while(flag == 0){
printf("Choose sort algorithm by entering its number\n 1-Bubble sort\n 2-Selection sort\n 3-Merge sort\n");
scanf("%d",&NAlgo);
switch (NAlgo)
{
case 1:
    bubbleSort(array,size);
    flag =1;
    break;
case 2:
    selectionSort(array,size);
    flag =1;
    break;
case 3:
    mergeSort(array, 0, size - 1);
    flag =1;
    break;
default:
    printf("Enter valid number\n");
    break;
}
}

    printf("\nSorted array is \n");
	print_sort_array(array,size);


    printf("\nEnter Number to search in sort array \n");
    scanf("%d",&search_number);

    index=  Binary_search(array,size,search_number);
    if(index == -1){
           printf("\n number is not found \n");
    }

    return 0;
}


void bubbleSort(int a[], int size_array) {

    int temp;
    bool Swap = true;

    while (Swap) {
        Swap = false;
        for (int i = 0; i < size_array-1; i++) {
            if (a[i] > a[i + 1]) {
                Swap = true;
                swap_bubblesort(a,i);
            }
        }
   size_array--;
    }
}


void selectionSort(int a[], int size_array)
{
    int i, j, min;
    for (i = 0; i < size_array; i++)
    {
        min = i;
        for (j = i+1; j <= size_array-1; j++){
          if (a[j] < a[min])
            min = j;
            }

            swap_selectionsort(a,i,min);

    }
}

void mergeSort(int arr[], int l, int r)
{
	if (l < r) {
		int m = l + (r - l) / 2;
		mergeSort(arr, l, m);
		mergeSort(arr, m + 1, r);

		merge(arr, l, m, r);
	}
}


void merge(int a[],int low, int mid, int high) {
   int l1, l2, i;

   for(l1 = low, l2 = mid + 1, i = low; l1 <= mid && l2 <= high; i++) {
      if(a[l1] <= a[l2])
         b[i] = a[l1++];
      else
         b[i] = a[l2++];
   }

   while(l1 <= mid)
      b[i++] = a[l1++];

   while(l2 <= high)
      b[i++] = a[l2++];

   for(i = low; i <= high; i++)
      a[i] = b[i];


}

void swap_bubblesort(int a[], int i)
{
 int temp;
 temp = a[i];
 a[i] = a[i+1];
 a[i+1] = temp;
}


void swap_selectionsort(int a[],int i,int min)
{
    int temp;
    temp =a[i];
    a[i]=a[min];
    a[min]=temp;
}

void print_sort_array (int a[],int size_array){
    for(int i=0;i<size_array;i++){
        printf("%d ",a[i]);
    }
}




int Binary_search ( int a[],int size_array, int number){
int low_index=0 , high_index=size_array-1;
while(low_index <= high_index){
    int mid_index = (low_index+high_index)/2;
    if(number == a[mid_index]){
        printf("\n number is found in index %d \n",mid_index );
        return 0;}
    else if (number < a[mid_index])
        high_index = mid_index-1;
    else
        low_index = mid_index+1;
}
return -1;
}



// anthor solve to bubble sort algorithm
/*
void bubbleSort(int a[], int size_array){
    int j,k,temp;
    for(k=1 ; k<=size_array-1 ; k++){
        for(j=0; j<=size_array-k-1; j++){
            if(a[j] > a[j+1]){
                swap(a,j);
            }
        }
    }
}
*/
