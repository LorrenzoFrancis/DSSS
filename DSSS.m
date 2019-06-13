clc;            % clear screen
clear;          % clear memory
close all;      % closes all other windows


prompt = {'Enter bit sequence below (max 52 bits):'}; % prompt for user
ititle = 'Input'; % title of dialog box
dims = [1 50]; % dimensions of dialog box
temp1 = inputdlg(prompt,ititle,dims); % takes in user input

temp2 = bin2dec(temp1{1}); %converts user input from binary  to decimal
bit_sequence = str2num(dec2bin(temp2,length(temp1{1})).'); %converts decimal to a binary string array then to number array

in_vect =  bit_sequence.'; % transpose the input bit_sequence vector 

t1 = length(temp1{1}); % number of bits in bit sequence user entered

psn = randi([0 1],1,t1); % random PSN bit sequence

Xor_out = xor(psn,in_vect); % X-OR of PSN and input bit sequence

f = 10^6;   % fixed bit rate
T = 1\f;    % period
t = T/99:T/99:T; % time for one bit of information 

BPSK = []; % intialized the BPSK vector

for i=1:length(bit_sequence)
    if Xor_out(1,i) == 0
        BPSK = [BPSK sin(2*pi*f*t)];
    else
       BPSK = [BPSK -sin(2*pi*f*t)];
    end
end

tt = T/99:T/99:T*t1; % time traversed by the BPSK modulated signal


%%%%%%%%%%%%%%%%%%%%%%%%%%%% GRAPHS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)

subplot(4,1,1); 
stairs(in_vect,'linewidth',3), grid on; 
title('Input Bit Sequence'); 
xlabel('Time(s)');      
ylabel('Amplitude(v)'); 
axis([1 t1 0 1]);

subplot(4,1,2); 
stairs(psn,'r','linewidth',3), grid on; 
title('Psuedo Random Noise Code'); 
xlabel('Time(s)');      
ylabel('Amplitude(v)'); 
axis([1 t1 0 1]);

subplot(4,1,3); 
stairs(Xor_out,'m','linewidth',3), grid on; 
title('X OR'); 
xlabel('Time(s)');      
ylabel('Amplitude(V)'); 
axis([1 t1 0 1]);

subplot(4,1,4); 
plot(tt,BPSK,'k','linewidth',3), grid on; 
title('BPSK'); 
xlabel('Time(s)');     
ylabel('Amplitude(V)'); 
axis([1 T*t1 -1 1]);

