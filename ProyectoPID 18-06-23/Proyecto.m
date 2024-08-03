classdef Proyecto
    %Proyecto App de PID
    
    properties
        nameAndPath
        name
        imageMatrix
        imageMap
        binaryImage
        grayScaleImage
        imageHistogram
        imageInfo
        equalizedImage
        invertedImage
        addImage
        susImage
        erImage
        dilImage
        eqHistogram
    end

    methods
        function obj = Proyecto()
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            [locFile, imageStruct] = readImage();
            obj.nameAndPath = locFile;
            obj.imageMatrix = imageStruct.imageMatrix;
            obj.imageMap = imageStruct.map;
            obj.imageInfo = imageStruct.imageInfo;

% ------------------------- Codigo en prueba -----------------------------

if(isempty(obj.imageMap)) % image is RGB or grayscale
  if(size(obj.imageMatrix, 3) == 1) % image is grayscale
      obj.grayScaleImage = obj.GraytoGray.grayScaleImage;
  else
      obj.grayScaleImage = obj.RGBtoGrayScale.grayScaleImage;
  end
else % image is indexed
      obj.grayScaleImage = obj.toGrayScale.grayScaleImage;
end

%------------vvv SECCION MODIFICADA 7-6-23 (LECTURA DE IMG BINARIAS) vvv-
if(islogical(obj.imageMatrix))
    obj.grayScaleImage = uint8(255*obj.imageMatrix);
    obj.imageMatrix = uint8(255*obj.imageMatrix);

end

%-------------^^^ SECCION MODIFICADA 7-6-23 (LECTURA DE IMG BINARIAS) ^^^-

% ------------------------- Codigo en prueba -----------------------------

            %obj.grayScaleImage = obj.toGrayScale.grayScaleImage;

            obj.binaryImage = obj.binarizeImage.binaryImage;

            %Modificado 7/6/23
            obj.imageHistogram = obj.getHistogram(obj.grayScaleImage).imageHistogram;

            A = split(obj.nameAndPath,'\');   
            A = A(length(A));
            A = split(A,'.');
            A = A(1);
            A = [A,'_Processed'];
            A = join(A);
            A = string(A);
            obj.name = A;
        end

        function [Proyecto] = binarizeImage(Proyecto)
            binImage = imbinarize(Proyecto.imageMatrix);
            %binImage = imbinarize(cast(Proyecto.imageMatrix,'uint8'));
            Proyecto.binaryImage = binImage;
        end

        function [Proyecto] = toGrayScale(Proyecto)
            Proyecto.grayScaleImage = ind2gray(Proyecto.imageMatrix, Proyecto.imageMap);
        end

        function [Proyecto] = GraytoGray(Proyecto)
            Proyecto.grayScaleImage = Proyecto.imageMatrix;
        end

        function [Proyecto] = RGBtoGrayScale(Proyecto)
            Proyecto.grayScaleImage = rgb2gray(Proyecto.imageMatrix);
        end

        function [Proyecto] = changeDepth(Proyecto,value)
            Proyecto.imageMap = gray(value);
            Proyecto.imageInfo.depth = value;
        end

        function [Proyecto] = getHistogram(Proyecto,img)
            Proyecto.imageHistogram = imhist(img);
        end

        function [Proyecto] = getEqHist(Proyecto)
            Proyecto.eqHistogram = imhist(Proyecto.equalizedImage);
        end

        function [Proyecto] = updateGrayScaleWithMap(Proyecto, map)
            Proyecto.grayScaleImage = ind2gray(Proyecto.imageMatrix, map);
        end

        function [Proyecto] = equalizeImage(Proyecto,img)
            Proyecto.equalizedImage = histeq(img);
        end

        function [Proyecto] = invertImage(Proyecto)
            Proyecto.invertedImage = imcomplement(Proyecto.grayScaleImage);
        end
        function [Proyecto] = photoInvertImage(Proyecto)
            Proyecto.invertedImage = 255 - (Proyecto.grayScaleImage);
        end
        function [Proyecto] = AddToImage(Proyecto,img2,w,h)
            img2 =  imresize(img2,[w h]);
            Proyecto.addImage = Proyecto.grayScaleImage + img2;
        end
        function [Proyecto] = SusToImage(Proyecto,img2,w,h)
            img2 =  imresize(img2,[w h]);
            Proyecto.susImage = Proyecto.grayScaleImage - img2;
        end
        function [Proyecto] = DilateImage(Proyecto,img,strc)
            Proyecto.dilImage = imdilate(img,strc);
        end
        function [Proyecto] = ErodeImage(Proyecto,img,strc)
            Proyecto.erImage = imerode(img,strc);
        end
        function [Proyecto] = Update(Proyecto, img)
            Proyecto.grayScaleImage = img;
        end
    end
end