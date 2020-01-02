function pict(data,varargin)
% PICT plot spectrum components 
% Usage:
%           pict(data)
%           pict(data,freq)
%           pict(data,lgd)
%           pict(data,freq,lgd)

if nargin==1
    load vctspt; lgd = [];
elseif nargin==2&&isnumeric(varargin) 
    freq = varargin;
elseif nargin==2&&iscell(varargin)
    load vctspt;  lgd = varargin{1};
elseif nargin==3
    freq = varargin{1}; lgd = varargin{2};
end

if size(data,1)<size(data,2)
    data = data';
end

if isrow(freq), freq = freq'; end

figure, 
plot(freq,data, 'linewidth', 2);
xlabel('F'); ylabel('Power');
set(gca,'fontsize',14);
legend(lgd);
grid on;
end