clc;clear;
list1=dir('data1/10%data/*.csv');
% list2=dir('data/4%data/*.csv');
% list3=dir('data/6%data/*.csv');
% list4=dir('data/8%data/*.csv');
% list5=dir('data/10%data/*.csv');
list_num=length(list1)
filename='data1/10%data/';
spread=10;
depth80_2=1;
i=1;
while i<=list_num
    energy=vpa(39.8+i*0.2,3);
    energy=char(energy);
    name=strcat(filename,num2str(energy),'MeV',num2str(spread),'%dose.csv');
    m=csvread(name,8,2);
    y=m(:,2);
    y=flipud(y);
    y1=y./max(y);
    continueflag=0;
    for j=1:100
        if y1(j)>=0.8
            if j<8
                continueflag=1;
                break
            else
%                 disp(name);
                if j<depth80_2
                    continueflag=1;
                    break
                else
                    depth80=j;
                    break
                end
            end
        end
    end
    if continueflag==1
        continueflag=0;
        i=i+1;
        continue;
    end
    for j=depth80:100
        if y1(j)<0.8
            temp=j-1;%temp depth80_2
            break;
        end
    end
    for j=temp+1:100
        if y1(j)<0.2
           depth20=j-1;
           if depth20>60
               if spread>2
                   spread=spread-2;
                   filename=strcat('data1/',num2str(spread),'%data/');
                   i=1;
                   break
               else
                   return
               end
           else
               depth80_2=temp;
               disp(name);
               disp(['depth80%:',num2str(depth80),'to',num2str(depth80_2),'mm']);
               disp(['depth20%:',num2str(depth20),'mm']);
               break

           end
        end
    end
    i=i+1;
end
