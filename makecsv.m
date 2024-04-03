clear all;

drugs = {"tretinoin", "adapalene", "tazarotene", "trifarotene", "alitretinoin", "bexarotene"};

numdrugs = 6;
numyears = 8;
startyear = 2014;

data = cell([numdrugs numyears]);

for drug = 1 : numdrugs
	for year = 1 : numyears
		data{drug,year} = readtable("data/" + drugs{drug} + "_" + num2str(year+startyear-1));
	end
end

%% By brand name

for drug = 1 : numdrugs
	drugdata = data(drug,:);

	brandnames = cell(0);
	for year = 1 : numyears
		if ~isempty(drugdata{year})
			brandnames = [brandnames ; unique(drugdata{year}.Brnd_Name)];
		end
	end
	brandnames = unique(brandnames)
end

% %% Adapalene
% adapalene = data(2,:)
%
% %% Tazarotene
% tazarotene = data(3,:)
%
