clear all; clc;
a = arduino('COM3','UNO');
i = 1;
while i <= 24
    x = readVoltage(a,'A1');
    t = string(datetime('now','TimeZone','America/New_York','Format','dd-MMM-yy HH:mm:SS'));
    fprintf("Date: %s moisture level of the plant is: %f\n",t,x)
    if (x > 3.7)
        fprintf("The plant is fine\n")
    else
        while x < 3.7   
            fprintf("The plant is thirsty\n")
            writeDigitalPin(a,'D2',1);
            pause(1);
            writeDigitalPin(a,'D2',0);    
            pause(10);
            x = readVoltage(a,'A1');
            if(x > 3.7)
                fprintf("Plant is now fine\n")
                break
            end
        end
    end
    i = i + 1;
    pause(3600);
end
