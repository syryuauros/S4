print("Hello World!")
a = 10
b = 20
c = a + b
print(c)
S = S4.NewSimulation()
sampler = S4.NewSpectrumSampler(0.1, 0.9, -- start and end frequencies
    { -- table of options
    InitialNumPoints = 33,
    RangeThreshold = 0.001,
    MaxBend = math.cos(math.rad(10)),
    MinimumSpacing = 1e-6
    })
while not sampler:IsDone() do
    x = sampler:GetFrequency()
    y = x * 2 -- compute the desired result
    sampler:SubmitResult(y)
end

spectrum = sampler:GetSpectrum()
for i,xy in ipairs(spectrum) do
    print(xy[1],xy[2])
end

interpolator = S4.NewInterpolator('linear', {
    {3.0, {14.2, 32}}, -- x, and list of y values
    {5.4, {4.6, 10}},
    {5.7, {42.7, 20}},
    {8.0, {35.2, 40}}
    })

for x = 0, 10, 0.1 do
    y1, y2 = interpolator:Get(x)
    print(x, y1, y2)
end

S:SetLattice({1,0}, {0,1}) -- 1D lattice
S:SetNumG(1)

S:AddMaterial("Vacuum", {1,0})

S:AddLayer(
	'Front', --name
	0,          --thickness
	'Vacuum')   --background material
S:AddLayerCopy('Back',  -- new layer name
               0,       -- thickness
               'Front') -- layer to copy
--
S:SetExcitationPlanewave(
	{0,0},  -- incidence angles (spherical coordinates: phi in [0,180], theta in [0,360])
	{1,0},  -- s-polarization amplitude and phase (in degrees)
	{0,0})  -- p-polarization amplitude and phase
--
if S4.arg == nil then S:SetFrequency(0.5)
else S:SetFrequency(S4.arg)
end

-- ZGETRF, ZGETRI, ZGEMM problem occured here!!
for z=-2,2,0.1 do
	print(S:GetEField({0,0,z}))
--	print(S:GetPoyntingFlux('Front',z))
--	print(S:GetEField({0,0,z}))
--	print(S:GetPoyntingFlux('Back',z))
end
