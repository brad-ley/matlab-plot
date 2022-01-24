%----------------------------------------------------
% Description of the project
%
% protein-dynamics.m
%
% 01. Used for plotting generic x/y data
%
% ...
% Brad Price (inspired by Qile Wu)

% Formatting parameters for figures
%----------------------------------------------------

%----------------------------------------------------
% Plot titles
title_str = 'High-field lineshapes'; % title
xlab = 'Field (T)'; % x-axis label
ylab = 'Signal (arb. u)'; % y-axis label
%----------------------------------------------------

%----------------------------------------------------
% Data import
savename = "light on-off Gd 406-537";
files = ["/Volumes/GoogleDrive/My Drive/Research/Data/2022/1/20/absorption_OffLight_exp.txt", "/Volumes/GoogleDrive/My Drive/Research/Data/2022/1/20/absorption_OnLight_exp.txt"];
names = ["Dark", "Lit"];
colors = ["black", "#0046FF"]; % hex code for 450 nm : "#0046FF"
style = ["-", ":"];
linewidth = 3;
field_delta = 8.62;
data = cell(size(files));
for i = 1:numel(files)
    data{i} = importdata(files(i));
    s = size(data{i});
    if s(2) > s(1)
        data{i} = data{i}';
    end
    data{i}(:,1) = data{i}(:,1) + field_delta;
end
%----------------------------------------------------

legend_font=20;

title_font=25;
xy_font=25;
tick_font=20;
text_font=20;
frame_thick=2;
tick_leng=[1,1].*0.03;

space_figure=0.06;

font_name='Arial';

title_dates=datestr(clock);
%----------------------------------------------------

%Universal constants
%------------------------------------------------

%------------------------------------------------


%Field parameters
%------------------------------------------------

%------------------------------------------------


%Material parameters
%------------------------------------------------

%------------------------------------------------


%Example: generating functions E_1(t)=E_10*cos(wt),E_2(t)=E_20*cos(wt)
%------------------------------------------------

%------------------------------------------------


%Title, legend, etc.
%------------------------------------------------
% title_cell=[title_dates(1:11),title_str];
title_cell = [title_str];
                          
legend_cell=cell(size(files));
for j=1:numel(data)
    
    legend_cell{j}=names(j);
    
end
%------------------------------------------------


            
%Figure 1: brief description
%------------------------------------------------
figure

x_min = Inf;
x_max = -Inf;
y_min = Inf;
y_max = -Inf;

for j=1:numel(files)
    
    plot(data{j}(:,1),data{j}(:,2), 'LineStyle',style(j),'Color',colors(j) ...
        ,'LineWidth',linewidth);
    hold on

    if min(data{j}(:,1)) < x_min
        x_min = min(data{j}(:,1));
    end
    if max(data{j}(:,1)) > x_max
        x_max = max(data{j}(:,1));
    end
    if min(data{j}(:,2)) < y_min
        y_min = min(data{j}(:,2));
    end
    if max(data{j}(:,2)) > y_max
        y_max = max(data{j}(:,2));
    end

end

legend(legend_cell,'FontSize',legend_font)
legend boxoff

xlim([x_min-(x_max-x_min)*space_figure,x_max+(x_max-x_min)*space_figure])
ylim([y_min-(y_max-y_min)*space_figure,y_max+(y_max-y_min)*space_figure]) %For Yscale linear

%ylim([y_min/2,y_max*2]) %For Yscale log

xlabel(xlab,'FontSize',xy_font)
ylabel(ylab,'FontSize',xy_font)

set(gca,'Yscale','linear')
%set(gca,'Yscale','log')
%set(gca,'Xtick',xtick_set)  %set the x-ticks: xtick_set=a vector
%set(gca,'Ytick',ytick_set)  %set the y-ticks: ytick_set=a vector
set(gca, 'YTickLabel', []) %for arb. u plotting
set(gca,'FontName',font_name)        
set(gca,'FontSize',tick_font)       
set(gca,'LineWidth',frame_thick)       
set(gca,'TickLength',tick_leng) 

title(title_cell,'FontSize',title_font)

set(gcf,'Position',[0,400,540,500],'color','w')
%------------------------------------------------
parts = fileparts(mfilename('fullpath'));
savefig(strcat(parts,filesep,'figures',filesep,savename,'.fig'))
saveas(gca, strcat(parts,filesep,'figures',filesep,savename,'.tif'))
