module DishesHelper

  def image_generator(height:, width:)
    "http://placehold.it/#{height}x#{width}"
  end

  def dish_img(img, type='main')
    if type == 'thumb'
      img.model.image? ? img : image_generator(height: '60', width: '60')
    elsif type == 'middle'
      img.model.image? ? img : image_generator(height: '280', width: '280')
    else
      img.model.image? ? img : image_generator(height: '600', width: '400')
    end
  end
end
