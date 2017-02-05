function Pd = findPd(z,R,lims)

Pd = mvncdf([lims(3);lims(4)],z,R) -  mvncdf([lims(1);lims(4)],z,R) -  mvncdf([lims(3);lims(2)],z,R) + mvncdf([lims(1);lims(2)],z,R); 

if Pd>1
    Pd = 1.0;
end

if Pd < .00001
    Pd = .001;
end
