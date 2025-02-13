<h1>Design</h1>
<h2>Описание</h2>
<p>Desigin - Это проект, который помогает вдохновиться пользователям, чтобы подобрать идеальный дизайн для своих комнат.</p>
<h2>Технологии</h2>
<p>1.UIKit</p>
<p>2.Firebase</p>
<p>3.RealmSwift</p>
<p>4.Mapkit</p>
<h2>Архитектура проекта</h2>
<h3>Проект организован в несколько директорий, каждая из которых отвечает за определённый функционал. Ниже приведено подробное описание структуры проекта.</h3>
<p>Папка Extension: Содержит расширение для стандартных классов и структур. Эти расширения помогают улучшить читаемость кода и повторное использование функционала.</p>
<p>Папка HomeScreen: Содержит все файлы и компоненты, связанные с главным экраном приложения. В данной директории реализована коллекция (UICollectionView), которая отображает основное содержимое экрана.</p>
<p>Папка LoginScreen: Содержит компоненты, необходимые для реализации экрана входа пользователя в систему.</p>
<p></p>Папка MapScreen: Содержит компоненты, необходимые для реализации функционала геолокации в приложении.</p>
<p>Папка PictureScreen: Содержит компоненты, необходимые для поиска изображений в интернете с использованием API Unsplash. Пользователь может искать изображения, вводя запросы в UISearchBar.</p>
<p>Папка PresentationController: Cодержит кастомный контроллер, который отображается при нажатии на коллекцию в HomeScreen.</p>
<p>Папка RegistrationScreen: Содержит компоненты, необходимые для реализации процесса регистрации пользователя в приложении.</p>
<p>Папка TabBarController: Содержит компоненты, отвечающие за навигацию внутри приложения с использованием таб-бара.</p>
<p>Папка TodoScreen: Содержит компоненты, которые позволяют пользователям записывать свои планы.</p>
