//
//	HXQMusicModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct HXQMusicModel{

	var filename : String!
	var icon : String!
	var lrcname : String!
	var name : String!
	var singer : String!
	var singerIcon : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		filename = dictionary["filename"] as? String
		icon = dictionary["icon"] as? String
		lrcname = dictionary["lrcname"] as? String
		name = dictionary["name"] as? String
		singer = dictionary["singer"] as? String
		singerIcon = dictionary["singerIcon"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if filename != nil{
			dictionary["filename"] = filename
		}
		if icon != nil{
			dictionary["icon"] = icon
		}
		if lrcname != nil{
			dictionary["lrcname"] = lrcname
		}
		if name != nil{
			dictionary["name"] = name
		}
		if singer != nil{
			dictionary["singer"] = singer
		}
		if singerIcon != nil{
			dictionary["singerIcon"] = singerIcon
		}
		return dictionary
	}

}