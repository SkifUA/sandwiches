module DishesHelper

  def image_generator(height:, width:)
    "http://placehold.it/#{height}x#{width}"
  end

  def dish_img(img, type='main')
    if type == 'thumb'
      img.model.image? ? img : image_generator(height: '50', width: '50')
    elsif type == 'middle'
      img.model.image? ? img : image_generator(height: '200', width: '200')
    else
      img.model.image? ? img : image_generator(height: '600', width: '400')
    end
  end
end
