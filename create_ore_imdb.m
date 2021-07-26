dir_path = "/l/users/20020063/owod_ovd/datasets/VOC2007/JPEGImages/*.jpg";
save_path = "/l/users/20020063/owod_ovd/datasets/VOC2007/JPEGImages_mat";
% dir_path = "/home/maaz/PycharmProjects/dino/images";
% save_path = "/home/maaz/PycharmProjects/dino/images";
images = dir(fullfile(save_path, '*.jpg'));


imdb = struct; 
imdb.images = {};
imdb.bboxes = {};
imdb.names = {};
r = 10;

status = dir(fullfile(save_path, '*.mat'));
if isempty(status)
    iter_start = 1;
else
    status = status(end).name;
    status = split(status, '_');
    status = status(end);
    status = split(status, '.');
    status = status(1);
    status = string(status);
    status = str2num(status);
    iter_start = status + 1;
end

tic;
for i=iter_start:length(images)
    if rem(i, r) == 0
        fprintf('On image: %i.\n', i);
        save(strcat(save_path, "/", "JPEGImages_", string(i), ".mat"), '-struct', 'imdb');
        clear imdb;
        imdb = struct; 
        imdb.images = {};
        imdb.bboxes = {};
        imdb.names = {};
        toc;
    end
    image_path = strcat(images(i).folder, "/", images(i).name);
    index = rem(i, r) + 1;
    imdb.images{index, 1} = imread(image_path);
    imdb.bboxes{index, 1} = [];
    imdb.names{index, 1} = images(i).name;
end

if ~isempty(i)
    save(strcat(save_path, "/", "JPEGImages_", string(i), ".mat"), '-struct', 'imdb');
    clear imdb;
end