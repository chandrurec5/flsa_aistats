function [err]=gtd(iters,flag);

S=7;
d=8;
Phi(2:S,8)=1;
for s=2:S
Phi(s,s)=2;
end;
Phi(1,1)=1;
Phi(1,8)=2;
Phi=Phi/2;



for i=1:S
%Phi(i,:)=Phi(i,:)/norm(Phi(i,:));
end;

rho=[0 7];
%x=load('x_good');
xmean=zeros(d,1);
xsum=zeros(d,1);
i=1;
load('samples');
L=size(samples,1);
N=30;%error measure on 30 states
gamma=0.99;



if(flag==1)
alpha=1/(7*2);
beta=1*alpha;
else
alpha=0.005;
beta=16*alpha;
end;

x=zeros(d,1);
y=zeros(d,1);

xmean=zeros(d,1);
xsum=zeros(d,1);

ymean=zeros(d,1);
ysum=zeros(d,1);
load('samples');
L=size(samples,1);
%x=[1 1 1 1 1 1 10 1]';
x=rand(d,1)-0.5;
x=x/norm(x);
y=[1 1 1 1 1 1 10 1]';
%y=rand(d,1)-0.5;
%y=y/norm(y);


%alpha=1/(4*d);
%beta=1*alpha;
%x=[2.8176e-05;  -4.1297e-01;   3.6010e-02;  -3.6921e-02;   1.1423e-01;   4.2432e-02;   2.4686e-01;  -5.1241e-03  ]; y=[-6.3034e-03;   7.1632e-01;  -6.3426e-02;   6.3299e-02;  -1.9924e-01;  -7.4572e-02;  -4.2955e-01; -6.1928e-03];

%alpha=0.005;
%beta=16*alpha;
%x=[  -6.3141e-17;  -9.2455e-02;  -5.4546e-02;   3.5729e-02;   1.5011e-01;   3.1071e-01;  -3.4954e-01;   2.1953e-15]; y=[  -6.9342e-14;   1.5842e-01;   9.3466e-02;  -6.1223e-02;  -2.5721e-01;  -5.3241e-01;   5.9895e-01;   5.6325e-14];


A=zeros(d);
C=zeros(d);
normx=zeros(iters,1);
normy=zeros(iters,1);
for t=1:iters
	st=randi(L);
	s=samples(st,1);
	a=samples(st,2);
	snext=samples(st,3);
	reward=samples(st,4);
	phi=Phi(s,:)';
	phid=Phi(snext,:)';
	At=phi*rho(a)*(phi-gamma*phid)';
	bt=reward*phi;
	x=(1-beta)*x+beta*(bt-At*y);
	y=y+alpha*At'*x;
	xsum=xsum+x;
	xmean=xsum/t;
	ysum=ysum+y;
	ymean=ysum/t;
	A=A+At;
	C=C+phi*phi';
	normx(t)=norm(xmean);
	normy(t)=norm(ymean);
	
end;
err=normy;
