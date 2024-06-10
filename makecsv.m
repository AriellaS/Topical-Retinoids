clear all;

drugs = {"tretinoin", "adapalene", "tazarotene", "trifarotene", "alitretinoin", "bexarotene"};
cols_byBrand = {'Tot_30day_Fills','Tot_Drug_Cst'};
cols_bySpecialty = {'Tot_30day_Fills'};
numDrugs = length(drugs);
numCols_byBrand = length(cols_byBrand);
numCols_bySpecialty = length(cols_bySpecialty);
numYears = 9;
startYear = 2013;

data = cell([numDrugs numYears]);

for drug = 1 : numDrugs
	for year = 1 : numYears
		data{drug,year} = readtable("rawdata/" + drugs{drug} + "_" + num2str(year+startYear-1));
	end
end

%% By brand name
for drug = 1 : numDrugs
	drugData = data(drug,:);

	brandNames = cell(0);
	for year = 1 : numYears
		if ~isempty(drugData{year})
			brandNames = [brandNames ; unique(drugData{year}.Brnd_Name)];
		end
	end
	brandNames = unique(brandNames);
	numBrands = length(brandNames);
	brandData = zeros(numYears,numCols_byBrand);

	varTypes = cell(1,numBrands);
	varTypes(:) = {'table'};
	drugTable = table('Size',[numYears numBrands],'VariableTypes',varTypes);
	drugTable.Properties.VariableNames = brandNames;

	for bn = 1 : numBrands
		brandName = convertCharsToStrings(brandNames{bn});
		for year = 1 : numYears
			if ~isempty(drugData{year})
				isBrand = drugData{year}.Brnd_Name==brandName;
				for c = 1 : numCols_byBrand
					b(c) = sum(drugData{year}.(cols_byBrand{c})(isBrand));
				end
			else
				b = zeros(1,numCols_byBrand);
			end
			brandData(year,:) = b;
		end
		brandTable = array2table(brandData);
		brandTable.Properties.VariableNames = cols_byBrand;
		drugTable.(brandNames{bn}) = brandTable;
	end
	writetable(splitvars(drugTable),"data_byBrand/" + drugs{drug} + "_byBrand" + ".xlsx");
end

%% By provider
for drug = 1 : numDrugs
	drugData = data(drug,:);

	specialties = cell(0);
	for year = 1 : numYears
		if ~isempty(drugData{year})
			specialties = [specialties; unique(drugData{year}.Prscrbr_Type)];
		end
	end
	specialties = unique(specialties);
	numSpecialties = length(specialties);
	specialtyData = zeros(numYears,numCols_bySpecialty);

	varTypes = cell(1,numSpecialties);
	varTypes(:) = {'table'};
	drugTable = table('Size',[numYears numSpecialties],'VariableTypes',varTypes);
	drugTable.Properties.VariableNames = specialties;

	for sp = 1 : numSpecialties
		specialty = convertCharsToStrings(specialties{sp});
		for year = 1 : numYears
			if ~isempty(drugData{year})
				isSpecialty = drugData{year}.Prscrbr_Type == specialty;
				for c = 1 : numCols_bySpecialty
					s(c) = sum(drugData{year}.(cols_bySpecialty{c})(isSpecialty));
				end
			else
				s = zeros(1,numCols_bySpecialty);
			end
			specialtyData(year,:) = s;
		end
		specialtyTable = array2table(specialtyData);
		specialtyTable.Properties.VariableNames = cols_bySpecialty;
		drugTable.(specialties{sp}) = specialtyTable;
	end
	writetable(splitvars(drugTable),"data_bySpecialty/" + drugs{drug} + "_bySpecialty" + ".xlsx");
end



