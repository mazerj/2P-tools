
int ii, jj, orderint = (int) order;
for(jj = 0; jj < x_length; jj++)
{
    for(ii = firstknot[jj]; ii < lastknot[jj]; ii++)
    {
        Sx[jj + (ii-1)*x_m] = bin(&(knots[-1]),ii,orderint,x[jj]);
    }
}

