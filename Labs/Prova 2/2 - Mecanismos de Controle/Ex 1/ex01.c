int a = 30;

int b = 45;

int c = -60;

int d = 25;


void ex01()
{

  if(a > b)
  {
    c = -c;

    d = c / 3;
  }

  /*
  if(a <= b) goto endIf

  c = -c
  d = c / 3
  
  endIf:
  */

  if(b >= a)
  {
    c = (a + b) * c;

    d = 1024;
  }

  /*
  if(b < a) goto endIf2

  c = (a + b) * c

  d = 1024

  endIf2:

  */

}