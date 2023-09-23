import Galleri from '@jlbelanger/galleri';
import Robroy from '@jlbelanger/robroy';

function initRobroy() {
	Robroy({ hideFullScreenButton: true });
}

Galleri.init({
	apiFoldersPath: '/json/folders.json',
	apiImagesPath: '/json/images.json',
	apiPath: '/api.php',

	callbacks: {
		afterCreateImage: ({ image }) => { initRobroy(); },
		afterCreateFolder: ({ folder }) => {},
		afterDeleteImage: ({ id }) => { initRobroy(); },
		afterDeleteFolder: ({ id }) => {},
		afterEditFolder: ({ folder }) => {},
		afterEditImage: ({ image }) => { initRobroy(); },
		afterLoadImage: ({ element }) => {},
		afterLoadImages: ({ images }) => { initRobroy(); },
		afterLoadFolder: ({ folder }) => {},
		afterLogin: () => {},
		afterLogout: () => {},
		afterUpdateImage: ({ element, image }) => {},
	},

	enableGrid: true,
	enableRewrites: true,
	folderItemElement: 'li',
	folderSeparator: ' > ',
	imageItemElement: 'figure',
	localStorageKey: 'authenticated',
	metaTitleSeparator: ' | ',

	modifiers: {
		adminBar: ({ element }) => {},
		breadcrumbList: ({ element, folder }) => {},
		breadcrumbItem: ({ element, folder }) => {},
		folderItem: ({ element, folder }) => {},
		folderForm: ({ addField, container, form }) => {},
		folderCreateForm: ({ addField, form }) => {},
		folderEditForm: ({ addField, form }) => {},
		imageCreateForm: ({ addField, form }) => {},
		imageEditForm: ({ addField, container, form }) => {},
		imageItem: ({ element }) => {
			element.querySelector('a').setAttribute('data-robroy', true);
		},
		modal: ({ element }) => {},
		spinner: ({ element }) => {},
		title: ({ element, title }) => {},
		toast: ({ element }) => {},
	},

	pageSize: 8,
	removePointerEventsOnLogin: false,
	selector: '#galleri',
	showAllImages: false,
});
