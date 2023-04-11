# sự khác biệt giữa mạng bridge mặc định và mạng bridge do người dùng tự tạo

https://docs.docker.com/network/bridge/#:~:text=Differences%20between%20user%2Ddefined%20bridges,option%2C%20which%20is%20considered%20legacy.
https://nguyenbinhson.com/2020/08/09/mang-bridge-trong-docker/

Các bridge tự định nghĩa cung cấp giải pháp DNS tự động giữa các container. Các container của bridge tự định nghĩa có thể nhận biết được các container còn lại thông qua tên hay bí danh. Một container tên là app có thể kết nối tới container tên là db thông qua tên miền db, mà không cần cấu hình DNS. Trong khi đó, các container của bridge mặc định chỉ có thể truy cập tới các container khác thông qua địa chỉ IP, trừ khi chúng được --link (một giải pháp cổ-điển) với nhau. Các link cần phải được tạo ra từ cả hai phía, kiến cho giải pháp này trở nên phức tạp hơn. Một cách khác là cấu hình /etc/hosts cho các container cần nhận thức nhau, nhưng giải pháp này khiến thao tác debug trở nên khó khăn hơn.

Các bridge tự định nghĩa cô lập hơn. Các container được tạo ra mà không được chỉ thị --network sẽ được kết nối vào bridge mặc định. Điều này tạo ra rủi ro rò rỉ thông tin. Sử dụng bridge tự định nghĩa sẽ giúp cô lập phạm vi kết nối xuống còn chỉ duy nhất các container trong mạng.

Các container có thể được cắm và rút khỏi bridge tự định nghĩa tại runtime. Trong khi đó, để cắm rút container khỏi bridge mặc định, cần phải dừng xóa và tạo lại container với một --network khác.

Mỗi bridge tự định nghĩa sử dụng các Linux bridge có thể cấu hình riêng biệt. Linux bridge của bridge mặc định cũng có thể cấu hình, nhưng việc thay đổi cấu hình xảy ra bên ngoài Docker, nên sẽ cần phải khởi động lại Docker. Các Linux bridge của các bridge tự định nghĩa được tạo ra bởi lệnh docker network create và được điều khiển bởi Docker nên sẽ không yêu cầu khởi động lại.

Các container được --link trên bridge mặc định chia sẻ tập biến môi trường với nhau. Và --link là cơ chế duy nhất có khả năng làm được việc đó một cách tự nhiên. Tuy vậy, các phương pháp thay thế tạo hiệu quả tương đương không phải là không có:
  Các container có thể mount chung một tập tin hay thư mục
  Các container có thể được khởi động trong cùng một docker-compose stack và theo đó có thể sử dụng chung một tập tin cấu hình biến môi trường.
  Các container có thể lấy cấu hình từ secrets hay configs của Docker Swarm nếu chúng được khởi động trong swarm mode.
