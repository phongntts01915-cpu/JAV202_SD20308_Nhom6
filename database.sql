-- Tạo database ASM_NEWS
CREATE DATABASE ASM_NEWS;
GO

USE ASM_NEWS;
GO

-- Bảng Categories (Loại tin)
CREATE TABLE Categories (
    Id NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL
);

-- Bảng Users (Người dùng)
CREATE TABLE Users (
    Id NVARCHAR(50) PRIMARY KEY,
    Password NVARCHAR(255) NOT NULL,
    Fullname NVARCHAR(255) NOT NULL,
    Birthday DATE,
    Gender BIT, -- 1: Nam, 0: Nữ
    Mobile NVARCHAR(20),
    Email NVARCHAR(255) UNIQUE,
    Role BIT NOT NULL -- 1: Quản trị, 0: Phóng viên
);

-- Bảng News (Tin tức)
CREATE TABLE News (
    Id NVARCHAR(50) PRIMARY KEY,
    Title NVARCHAR(500) NOT NULL,
    Content NTEXT NOT NULL,
    Image NVARCHAR(255),
    PostedDate DATE NOT NULL,
    Author NVARCHAR(50) NOT NULL,
    ViewCount INT DEFAULT 0,
    CategoryId NVARCHAR(50) NOT NULL,
    Home BIT DEFAULT 0, -- 1: Hiển thị trên trang chủ, 0: Không
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id),
    FOREIGN KEY (Author) REFERENCES Users(Id)
);

-- Bảng Newsletters (Đăng ký nhận tin)
CREATE TABLE Newsletters (
    Email NVARCHAR(255) PRIMARY KEY,
    Enabled BIT DEFAULT 1 -- 1: Còn hiệu lực, 0: Đã hủy
);

-- Thêm dữ liệu mẫu
INSERT INTO Categories VALUES 
('SPORT', N'Thể thao'),
('TECH', N'Công nghệ'),
('HEALTH', N'Sức khỏe'),
('BUSINESS', N'Kinh doanh'),
('ENTERTAINMENT', N'Giải trí');

INSERT INTO Users VALUES 
('admin', '123456', N'Quản trị viên', '1990-01-01', 1, '0123456789', 'admin@news.com', 1),
('reporter1', '123456', N'Phóng viên 1', '1995-05-15', 0, '0987654321', 'reporter1@news.com', 0),
('reporter2', '123456', N'Phóng viên 2', '1992-10-20', 1, '0111222333', 'reporter2@news.com', 0);

INSERT INTO News VALUES 
('NEWS001', N'Tin thể thao mới nhất', N'Nội dung tin thể thao...', 'sport1.jpg', '2024-01-15', 'reporter1', 150, 'SPORT', 1),
('NEWS002', N'Công nghệ AI phát triển', N'Nội dung về công nghệ AI...', 'tech1.jpg', '2024-01-16', 'reporter2', 200, 'TECH', 1),
('NEWS003', N'Sức khỏe mùa đông', N'Nội dung về sức khỏe...', 'health1.jpg', '2024-01-17', 'reporter1', 100, 'HEALTH', 0),
('NEWS004', N'Thị trường chứng khoán', N'Nội dung về kinh doanh...', 'business1.jpg', '2024-01-18', 'reporter2', 80, 'BUSINESS', 1),
('NEWS005', N'Phim mới ra mắt', N'Nội dung giải trí...', 'entertainment1.jpg', '2024-01-19', 'reporter1', 120, 'ENTERTAINMENT', 0);

INSERT INTO Newsletters VALUES 
('user1@gmail.com', 1),
('user2@gmail.com', 1),
('user3@gmail.com', 0);
